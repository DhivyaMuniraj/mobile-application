package com.ces.androidappkit.ui.home.adapter

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.ces.androidappkit.databinding.ItemHomeSliderBinding
import com.ces.androidappkit.ui.home.model.ModelSlider

class AdapterSlider(
    private val mList: List<ModelSlider>
) :
    RecyclerView.Adapter<AdapterSlider.ViewHolder>() {

    var onItemClick: ((ModelSlider) -> Unit)? = null
    lateinit var context: Context

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): ViewHolder {
        val binding = ItemHomeSliderBinding.inflate(
            LayoutInflater.from(parent.context),
            parent,
            false
        )
        context = parent.context
        return ViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        with(holder) {
            with(mList[position]) {
                binding.model = this
            }
        }
    }

    override fun getItemCount(): Int {
        return mList.size
    }


    inner class ViewHolder(val binding: ItemHomeSliderBinding) :
        RecyclerView.ViewHolder(binding.root) {
        init {
            itemView.setOnClickListener {
                onItemClick?.invoke(mList[adapterPosition])
            }
        }
    }

}
