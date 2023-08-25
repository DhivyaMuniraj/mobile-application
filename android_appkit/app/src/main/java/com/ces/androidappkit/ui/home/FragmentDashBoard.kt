package com.ces.androidappkit.ui.home

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.fragment.app.viewModels
import androidx.recyclerview.widget.GridLayoutManager
import androidx.recyclerview.widget.LinearLayoutManager
import com.ces.androidappkit.R
import com.ces.androidappkit.databinding.FragmentHomeBinding
import com.ces.androidappkit.ui.home.model.ModelProduct
import com.ces.androidappkit.ui.home.model.ModelSlider
import com.ces.androidappkit.ui.home.adapter.AdapterProducts
import com.ces.androidappkit.ui.home.adapter.AdapterSlider
import com.ces.androidappkit.util.AppUtils
import com.ces.androidframework.displayMetrics.Screen

class FragmentDashBoard : Fragment() {

    private var _binding: FragmentHomeBinding? = null

    // This property is only valid between onCreateView and
    // onDestroyView.
    private val binding get() = _binding!!
    private val viewModel: ViewModelDashBoard by viewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        _binding = FragmentHomeBinding.inflate(inflater, container, false)
        val root: View = binding.root
        setViewDimensions()
        setUiForSearch()
        addObservers()
        return root
    }

    private fun addObservers() {
        viewModel.sliderList.observe(viewLifecycleOwner) {
            it?.let {
                setRecyclerViewSlider(it as ArrayList<ModelSlider>)
            }
        }
        viewModel.productList.observe(viewLifecycleOwner) {
            it?.let {
                setRecyclerViewProduct(it as ArrayList<ModelProduct>)
            }
        }
    }

    private fun setUiForSearch() {
        val cornerRadiusForSearchView = 50f
        AppUtils.setGradientDrawableBackground(
            binding.clSearch,
            requireActivity().getColor(R.color.white),
            requireActivity().getColor(R.color.white),
            cornerRadiusForSearchView
        )
    }

    private fun setViewDimensions() {
        val heightOfSlider = (Screen.height) * 0.35
        binding.recyclerViewSlider.layoutParams.height = heightOfSlider.toInt()
        binding.recyclerViewSlider.requestLayout()
    }

    override fun onDestroyView() {
        super.onDestroyView()
        _binding = null
    }

    private fun setRecyclerViewSlider(data: ArrayList<ModelSlider>) {
        binding.recyclerViewSlider.layoutManager =
            LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
        val adapter = AdapterSlider(data)
        binding.recyclerViewSlider.adapter = adapter
        adapter.onItemClick = {
            // Do whats required
        }
    }

    private fun setRecyclerViewProduct(data: ArrayList<ModelProduct>) {
        binding.recyclerViewProducts.layoutManager =
            GridLayoutManager(context, 2)
        val adapter = AdapterProducts()
        adapter.submitList(data)
        binding.recyclerViewProducts.adapter = adapter
        adapter.onFavouriteClick = {
            val selectedProduct = it
            data.forEachIndexed { index, productData ->
                if (selectedProduct.id == productData.id) {
                    data[index] = ModelProduct(productData.id, !productData.isFavourite)
                }
            }
            setRecyclerViewProduct(data)
        }
    }
}